% Base de conocimiento para diagnóstico médico básico

% Síntomas por enfermedad
enfermedad(resfriado, [estornudos, dolor_garganta, congestion_nasal]).
enfermedad(gripe, [fiebre, dolor_cabeza, dolor_muscular, fatiga, escalofrios]).
enfermedad(alergia, [estornudos, picor_ojos, congestion_nasal, lagrimeo]).
enfermedad(covid19, [fiebre, tos_seca, perdida_olfato, perdida_gusto, dificultad_respirar]).
enfermedad(infeccion_estomacal, [dolor_abdominal, nauseas, vomitos, diarrea, fiebre]).
enfermedad(migrana, [dolor_cabeza_intenso, sensibilidad_luz, sensibilidad_ruido, nauseas]).
enfermedad(anemia, [fatiga, palidez, mareos, debilidad]).

% Calcular cuántos síntomas coinciden (para encontrar la enfermedad más probable)
contar_coincidencias([], _, 0).
contar_coincidencias([S|Resto], SintomasUsuario, N) :-
    member(S, SintomasUsuario),
    !,
    contar_coincidencias(Resto, SintomasUsuario, N1),
    N is N1 + 1.
contar_coincidencias([_|Resto], SintomasUsuario, N) :-
    contar_coincidencias(Resto, SintomasUsuario, N).

% Regla principal para diagnosticar basado en coincidencias
% Devuelve la enfermedad y el número de síntomas que coinciden
diagnosticar(Enfermedad, SintomasUsuario, Coincidencias) :-
    enfermedad(Enfermedad, SintomasEnfermedad),
    contar_coincidencias(SintomasEnfermedad, SintomasUsuario, Coincidencias),
    Coincidencias > 0. % Al menos un síntoma debe coincidir

% Listar todos los síntomas posibles (para la interfaz de usuario)
sintomas_posibles(Sintomas) :-
    findall(S, (enfermedad(_, L), member(S, L)), TodosSintomas),
    sort(TodosSintomas, Sintomas). % sort elimina duplicados
